# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT82 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.2.tgz"
  sha256 "43000b9b95d1c10a072a4dce631628dbd8e48af5cac6cd6cbe3b0649ed5fd2d6"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "329abcd0d3623bf2edc86790629af5d32edc909c1efebe2235d361a5fc8a444b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "74773d2e183adce1c0d010d34d57558ec5cd9494a70d4ecf176a59352dd44c94"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "17f0c09c22dec2119c6d7d697551248bf4ef1bf7a8e3ed63a2bd5eadf6e3d8ac"
    sha256 cellar: :any_skip_relocation, ventura:       "7d5f4bc2d0fb83b44973afbc36ac30a479f623cd859c09f30622db14e6c5fb5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "055311bcd220fc373a20fbc2020e96b74f802dc30e0045a278896c5987c7ec59"
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
