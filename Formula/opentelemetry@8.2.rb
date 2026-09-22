# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "af14e49e0f98b35db4656519dff644a04243ad8ca4e7465fa20f2f616af842a7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "762e2b1ddda7e92c80926782d3aa7c22ea210351fa7c858f75d7fa0b75e1e0f7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "49db9ae5064a0bfd5ea369554ca4d81922e53feec5912172af496259eaa5c737"
    sha256 cellar: :any,                 arm64_linux:       "8f5d36df783d48f233f4e20d20fadf0e5205393444203f3dde820f179767dfe0"
    sha256 cellar: :any,                 x86_64_linux:      "319767281fbca1c39b2bb9235a2873ec2cabd5cb2f2f3a7fba96093874da5a20"
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
