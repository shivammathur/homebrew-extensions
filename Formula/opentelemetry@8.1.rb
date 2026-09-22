# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT81 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.2.tgz"
  sha256 "a355329259f373c5c7327e66310481726cfabac50cb5483eba000bec791d5017"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a0c6f51208045c6b90ff080112521922c3275e7082ad5761245b492c06fae0cd"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5b60fe065d8c5c6a9c3c09386e6e958dc9753cf44c366cba02a4c295d77d966b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "ec4a2c946bd7624548acedc8a79c23eac84b0116bf51219729ccf97687cf39c1"
    sha256 cellar: :any,                 arm64_linux:       "15fc88430259d05451a6c509d3671838610522e11db7bdae6b1808973a2d0dd8"
    sha256 cellar: :any,                 x86_64_linux:      "9152541d951a5676c601ade9da2d1b17937fd4f85a9ff157e790e030cb2c5a07"
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
