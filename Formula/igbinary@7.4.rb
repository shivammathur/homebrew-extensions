# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.4.tar.gz"
  sha256 "30a70eca00d0acaf4979ee532143aebe11cb325a5356b086f357cc3f69fe5550"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "38b1226bcfb4ace3d232a05a44f2bab8124cba057f337519bb8b87d0a93fed37"
    sha256 cellar: :any_skip_relocation, big_sur:       "816b7c415315f6cefce0e9d11c31ccfbb2d7449d997c29ae120f7cac58c75099"
    sha256 cellar: :any_skip_relocation, catalina:      "cc97cf4da4a88b5d8e1a776a1438271a8db1c335f00276c81db4db61c2566d53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9dbe95407651b9039d75486b25dbea6b63c2f580badd6040999b6e3f0daf8ec"
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
