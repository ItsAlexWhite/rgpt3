% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chatgpt_single.R
\name{chatgpt_single}
\alias{chatgpt_single}
\title{Makes a single chat completion request to the ChatGPT API}
\usage{
chatgpt_single(
  prompt_role = "user",
  prompt_content,
  model = "gpt-3.5-turbo",
  output_type = "complete",
  max_tokens = 100,
  temperature = 1,
  top_p = 1,
  n = 1,
  stop = NULL,
  presence_penalty = 0,
  frequency_penalty = 0
)
}
\arguments{
\item{prompt_role}{character (default: 'user') that contains the role for the prompt message in the ChatGPT message format. Must be one of 'system', 'assistant', 'user' (default), see \url{https://platform.openai.com/docs/guides/chat}}

\item{prompt_content}{character that contains the content for the prompt message in the ChatGPT message format, see \url{https://platform.openai.com/docs/guides/chat}. This is the key instruction that ChatGPT receives.}

\item{model}{a character vector that indicates the \href{https://platform.openai.com/docs/api-reference/chat/create#chat/create-model}{ChatGPT model} to use; one of "gpt-3.5-turbo" (default), "gpt-3.5-turbo-0301"}

\item{output_type}{character determining the output provided: "complete" (default), "text" or "meta"}

\item{max_tokens}{numeric (default: 100) indicating the maximum number of tokens that the completion request should return (from the official API documentation: \emph{The maximum number of tokens allowed for the generated answer. By default, the number of tokens the model can return will be (4096 - prompt tokens).})}

\item{temperature}{numeric (default: 1.0) specifying the sampling strategy of the possible completions (from the official API documentation: \emph{What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or \code{top_p} but not both.})}

\item{top_p}{numeric (default: 1) specifying sampling strategy as an alternative to the temperature sampling (from the official API documentation: \emph{An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10\% probability mass are considered. We generally recommend altering this or \code{temperature} but not both.})}

\item{n}{numeric (default: 1) specifying the number of completions per request (from the official API documentation: \emph{How many chat completion choices to generate for each input message. \strong{Note: Because this parameter generates many completions, it can quickly consume your token quota.} Use carefully and ensure that you have reasonable settings for max_tokens and stop.})}

\item{stop}{character or character vector (default: NULL) that specifies after which character value when the completion should end (from the official API documentation: \emph{Up to 4 sequences where the API will stop generating further tokens.})}

\item{presence_penalty}{numeric (default: 0) between -2.00  and +2.00 to determine the penalisation of repetitiveness if a token already exists (from the official API documentation: \emph{Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.}). See also: \url{https://beta.openai.com/docs/api-reference/parameter-details}}

\item{frequency_penalty}{numeric (default: 0) between -2.00  and +2.00 to determine the penalisation of repetitiveness based on the frequency of a token in the text already (from the official API documentation: \emph{Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.}). See also: \url{https://beta.openai.com/docs/api-reference/parameter-details}}
}
\value{
A list with two data tables (if \code{output_type} is the default "complete"): [\link{1}] contains the data table with the columns \code{n} (= the mo. of \code{n} responses requested), \code{prompt_role} (= the role that was set for the prompt), \code{prompt_content} (= the content that was set for the prompt), \code{chatgpt_role} (= the role that ChatGPT assumed in the chat completion) and \code{chatgpt_content} (= the content that ChatGPT provided with its assumed role in the chat completion). [\link{2}] contains the meta information of the request, including the request id, the parameters of the request and the token usage of the prompt (\code{tok_usage_prompt}), the completion (\code{tok_usage_completion}) and the total usage (\code{tok_usage_total}).

If \code{output_type} is "text", only the data table in slot [\link{1}] is returned.

If \code{output_type} is "meta", only the data table in slot [\link{2}] is returned.
}
\description{
\code{chatgpt_single()} sends a single \href{https://platform.openai.com/docs/guides/chat}{chat completion request} to the Open AI GPT API. Doing so, makes this equivalent to the sending single completion requests with \code{gpt3_single_completion()}. You can see the notes on chat vs completion requests here: \url{https://platform.openai.com/docs/guides/chat/chat-vs-completions}. This function allows you to specify the role and content for your API call.
}
\details{
For a general guide on the completion requests, see \url{https://platform.openai.com/docs/api-reference/chat}. This function provides you with an R wrapper to send requests with the full range of request parameters as detailed on \url{https://beta.openai.com/docs/api-reference/completions} and reproduced below.

Parameters not included/supported:
\itemize{
\item \code{logit_bias}: \url{https://platform.openai.com/docs/api-reference/chat/create#chat/create-logit_bias}
\item \code{stream}: \url{https://platform.openai.com/docs/api-reference/chat/create#chat/create-stream}
}
}
\examples{
# First authenticate with your API key via `gpt3_authenticate('pathtokey')`

# Once authenticated:

## Simple request with defaults:
chatgpt_single(prompt_content = 'You are a teacher: explain to me what science is')

## Instruct ChatGPT to write ten research ideas of max. 150 tokens with some controls:
chatgpt_single(prompt_role = 'user', prompt_content = 'Write a research idea about using text data to understand human behaviour:'
   , temperature = 0.8
   , n = 10
   , max_tokens = 150)

## For fully reproducible results, we need `temperature = 0`, e.g.:
chatgpt_single(prompt_content = 'Finish this sentence:/n There is no easier way to learn R than'
    , temperature = 0.0
    , max_tokens = 50)

}
