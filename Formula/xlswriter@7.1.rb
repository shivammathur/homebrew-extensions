# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1a3882f41ecc3f41d434431b46634e539482c2646d2213f0aae3f97daa642efe"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2b0a0e6ce79625a29955b0fd0e00b355a0fbde090a7eb806c3f6add9c1deef0"
    sha256 cellar: :any_skip_relocation, monterey:       "33374bed41a53dc07011d2c4a1f09e02afe765c59097e3734aaaf0e895e84d8b"
    sha256 cellar: :any_skip_relocation, big_sur:        "b2cc6302eea87295e71ec93d4d6b84bb3ec857ae41e5f4abf812187f9cfe7131"
    sha256 cellar: :any_skip_relocation, catalina:       "e8ef1d6ce98c6858c180bc1127d9e7116d3cd17ba009e091fd7c7923cacdbb34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "34204539dc51f7a451a8dbc132adb383e114a0e0a548b79f2796e79f76f236c8"
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
