# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT86 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.2.1.tgz"
  sha256 "de8315ed3299536f327360a37f03618ab8684c02fbf8dfd8f489c025d88a6498"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "03611cafe21565aa909398d6f50d7e53b4ec0fbb5479d3fa566b79e979ec89e5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e81793df2b10e464e2c3c5f065db4a996b82e01b12f943104f97a8550580cc08"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17abbf6d50d3c80bab6693e5de39358f2fcbb456aae660b19f102f60dce28899"
    sha256 cellar: :any_skip_relocation, sonoma:        "71b1cb29cedcf9ba24260ffab9f3b470868c460e6f0c65ad82846753e80637c5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "85aa59018299b7caeb78f7418ab12877d93c53aa65aaff17451fa31058e9f31f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0de49b306ed0ec2363f696604ed3466ac955dea9557ed5acee57bf7ec68cc47"
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
