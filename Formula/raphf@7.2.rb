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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "96dad88202d44d09697386d9366fdc761f4db24da482688cfaa94f9ba0696957"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c78f543e79898df5d7bf149259bc369bbdccf95a24b951cea068559d6df4be5b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2eb26dc2308e426aa8070db96e72bbdac4ca44469b8e4427ab2b322337febe24"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "be830a1686531327fa8031657e11bcb7ff7ccdd80790cdac385b9d9c282a4b5e"
    sha256 cellar: :any_skip_relocation, ventura:        "5ecffc25b5d41740fa864d22e9322280d22fa68e017b1d548fd3196307e02172"
    sha256 cellar: :any_skip_relocation, monterey:       "00e7d84b2f90c1e9e4e2461423dd691c75ce5966bddbd4eaace727a36736717c"
    sha256 cellar: :any_skip_relocation, big_sur:        "1e8aba894a3955e5184145e2cc01379879380416981766288cce4d5930f1d23d"
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
