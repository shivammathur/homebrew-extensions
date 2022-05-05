# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f0f2af50d22674fb40eea9bbb36310cbb3de6398a2f42c66e31f193708a666bf"
    sha256 cellar: :any_skip_relocation, big_sur:       "6e6c873eadeb61bc79f574e2328ea3497d8235f4c0e9839b010672726878e537"
    sha256 cellar: :any_skip_relocation, catalina:      "562afffd1b45b8e341496a242e744e18b13ac17867b6013423d65f5f480982de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3d9d74f85d9522e0b7f59df1625678d1274b0d207b04a74809bd69ef1cac6c1"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
