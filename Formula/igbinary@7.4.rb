# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.15.tar.gz"
  sha256 "6fcbd7813eea1dfe00ec72a672cedb1d1cce06b2f23ab3cb148fa5e3edfa3994"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "006df66f5b03686d83eafe8f3ae6206194dc16bc7b21bccc2552b349cbece411"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b21ea795df5d441a0de02e7715d2a8f593d522dc52b2439f6d55cd6224143df0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4ae9aed2ca08f0802f2f6899769393f70fd7d5606c2ca074860755b4cf8064a4"
    sha256 cellar: :any_skip_relocation, ventura:        "08281eef681924515a1a54a735bbb1336ce54a393a9cf6b55656d5ea9f412de1"
    sha256 cellar: :any_skip_relocation, monterey:       "a046a0aeebf84a904c8f9ed6aef3ecf188537c96374bacb56065f2ad3a50aef9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc401801b4677d2fdf5af83acb0a11d78f627464361fde6ab82bdcaa0b801504"
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
