# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT56 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-1.0.2.tgz"
  sha256 "6b4e785adcc8378148c7ad06aa82e71e1d45c7ea5dbebea9ea9a38fee14e62e7"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4b96b47bd55533932c71f586b5fff48a06ab489361712fe293f38cda6bc6d00d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "12553069b54cf22c3647da47c8d1b42412f3f82a6831e8f9697ab793f0ffe8a6"
    sha256 cellar: :any_skip_relocation, monterey:       "0cebd1fb10dea3672e6d72a2d965c6c890a45fc41b273491a11154557c6344cc"
    sha256 cellar: :any_skip_relocation, big_sur:        "05c3f4996ab4f75a046facf4d5e9a0f8f8ce850c4b7cd1c17882c475c58015d2"
    sha256 cellar: :any_skip_relocation, catalina:       "1bda17976b1db4d5cb769c6f4508e5e928e98eefe54582b490e8b055bee950f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d878f458bc88ea6baa2adcc26f110c46f1d3750d7dd7acb69a094868524c7ca3"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
