# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "944035acb337e30d07cd7e832b05df217b42e6403aa84b6332a606eb05b26328"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ce631db16c10701fcfc33ffb11b75720ab2f40cef1321757a911325bab4737a2"
    sha256 cellar: :any_skip_relocation, monterey:       "b44e40a6850ee405d927afdee2521c2be18d40ae0b63082c2c14348612a65637"
    sha256 cellar: :any_skip_relocation, big_sur:        "4037f7ada41bd2954a071f0ced4a2c939ced94bdf499cadb8cdd109848e00ad6"
    sha256 cellar: :any_skip_relocation, catalina:       "9084a87799368cee8f1e8a264ad2053ebac9e456fcf788e83e9b24d81ee79af2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ded2466c9c53200d8bd4a63ca1793208a38dbce1e8b7bb2d089c889e4db1a70"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
