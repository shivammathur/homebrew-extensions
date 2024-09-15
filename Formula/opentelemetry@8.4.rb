# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "32975dc023ccf62c052ea29790ec723e140f24d6ef1380560521899ee089abcc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ca1463e2d668ea58c839fdb46857a8d94025b90d4e0a2c997bb81bd6f5e818da"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b2229cebf3bbdf3ff4cfb315cd4b5bbb69a48d2c16122eee612a308010d19392"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d22fe59d7e6300d3e0f30f7e10abccbf2e121a5bf60db6a7c7a95331e984dc73"
    sha256 cellar: :any_skip_relocation, ventura:        "52086cae9b738a9cb3ef35559a3c7d62e72404e7040eb741a6cf4886c597d80b"
    sha256 cellar: :any_skip_relocation, monterey:       "6a61d3d5bb08c409490f1b1bde9f10a7686633882ac5441b778ce8626ded7f39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d611d5082175e560dec1ae9eb17a49543a15ac5780ad47317190095e4293e740"
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
