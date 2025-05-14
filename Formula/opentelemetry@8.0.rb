# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.3.tgz"
  sha256 "8371225bbc4dbd6ba3e966b1588c22c81c6a87fcbece64cd2b3294cc03b2885d"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a58c5aba0583e481db6db26ef1f3b64e92aa2a42bda3afa8693ce8e78c269c73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "814ab0cb21f9d374eff168110893b8b77cace46bde256625cde83e6478915c43"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b024e0e54ed1815ff073e9c0cdd234b71dd9a605b793f89341ca013bc1b38b06"
    sha256 cellar: :any_skip_relocation, ventura:       "686bbbdf713821688300429600523fdcac5702d7c888e6fe185c1d6f5f040db5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c42137f7aaa19d33a14e9da13a0fc0aa2cf68ab931a7ae1c5cfbb5b21153a88"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
