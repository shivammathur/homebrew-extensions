# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2eb26dc2308e426aa8070db96e72bbdac4ca44469b8e4427ab2b322337febe24"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "be830a1686531327fa8031657e11bcb7ff7ccdd80790cdac385b9d9c282a4b5e"
    sha256 cellar: :any_skip_relocation, monterey:       "1aeeb2cb696d7858775fd697639928c31bc3f22c943cfe5f863233eaea7426db"
    sha256 cellar: :any_skip_relocation, big_sur:        "1e8aba894a3955e5184145e2cc01379879380416981766288cce4d5930f1d23d"
    sha256 cellar: :any_skip_relocation, catalina:       "d5c5b9ae7756d4bde0c3ea8c5a21d09c24706a628281a671ad6579aad650bff5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f45ee330625f3a3d16caab2ded0f18a844e3c142dc73d0fbbfe4343a7f6f510d"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
