# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "891c0b44e8c5b6cff6b7ab36e72e3501a13832271bd8146bb9f617b088f01317"
    sha256 cellar: :any, arm64_tahoe:       "2764f7e26adc0db235413013bcbde6ebcf2464bb9ed6e6788cfb5253b9fa62ab"
    sha256 cellar: :any, arm64_sequoia:     "77b1931a95e804115192c453e1de3abd380d4d9fd0ce569572ded10b0005eb5b"
    sha256 cellar: :any, arm64_linux:       "4676a816d578d6c9e902f821ba8b777915445f69372a5a829b8be09aae521dca"
    sha256 cellar: :any, x86_64_linux:      "dfca2c6df2a9790249f4695073f72d5cc521331cca87cad4452e470acb7d025c"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
