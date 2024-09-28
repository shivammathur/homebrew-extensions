# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7e7e3b2451c4e3f14e49fd15afd3ef97ca4347079ee7c291fa35a401d8ea0d62"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f9b591b1abb9a81ae26152fa586c9d53fdd7f8d248701d0d996658a6e0141da9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "025dacf7c98b0ab5e141f18384a8555912b8e3b376059dda88e9672ba2e44a61"
    sha256 cellar: :any_skip_relocation, ventura:       "3fe2664f5a4f7365a2a8a171447c0fc5022e89e14b32f7dbb97284a1628f176b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2498b6a1da7a5d5e0e0e2e00e0f600078f8b70f22edec7145ccd7c6c16665789"
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
