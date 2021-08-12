# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3697bd759c9f03374c6afcddba1b4b498468c9aba443e6142542ca5f0d7b16e6"
    sha256 cellar: :any_skip_relocation, big_sur:       "64513fd2dc94699e48b3d95aa3d5a1ef2a12ec8e81f194f485cdc2fc8f236b92"
    sha256 cellar: :any_skip_relocation, catalina:      "77ede3273c7fe6cf1009184e0cdb91eca48be52c49564fb88bf4cd30d42dc446"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75101b2cfe9430800314509e2e13953c2dedbadf7456c891ecc043df7a3e2cd8"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
