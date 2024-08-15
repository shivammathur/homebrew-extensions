# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9935417eaa7c30c895ee98071c667129643edb3ec4dd0eb640d09cf3b00affec"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "392b169ca3d77d64d4e3f1cb2233e918d593ee2e3f8882213ae3e79c9f14563e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "76e0128ca6e46fded604b436b6b5e7116a6a9f6a105ef7dec43f5c248040403b"
    sha256 cellar: :any_skip_relocation, ventura:        "0f7fb6dbe2e476e3eecae47b0f14f769a1d251665e7eb8211785a921ee1cc43e"
    sha256 cellar: :any_skip_relocation, monterey:       "e9287240d4a20870c4648e7f7885c85f0dfb7b1f62bb90e48c97a319f5881b00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "59fe0b70e8d7833d649dc79ab530cb50edbc6d198f4a6c7c9b8d8292002e9c70"
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
