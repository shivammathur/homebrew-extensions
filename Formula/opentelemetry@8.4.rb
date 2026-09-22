# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "8c03340143de0b2ac96f1b98f460941aea109953baff90f72ef26f21fdf6da96"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7d328284644b531f8c6bd4f012bfd3a0bacaa7b1210f878d1cf6187a7427d81c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9ffa9cb09057ff2f9f4c0bb033a8ba5a32d86edd9de01bba151084d2863cf669"
    sha256 cellar: :any,                 arm64_linux:       "b30e215bc7f78037c5119b496c86e691457c88851f4bec19be8629dc95110fa2"
    sha256 cellar: :any,                 x86_64_linux:      "b7eaba4a1b95372ce7c632a652b17454b53748945b4586668cb30dfa2007e403"
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
