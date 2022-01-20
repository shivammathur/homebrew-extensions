# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e678612b33e16c337d461ffde2d12d437a20a1dd34d7e8201a26c95a157645a7"
    sha256 cellar: :any_skip_relocation, big_sur:       "9ea432a2bd21f50dc6d5d9042416cd569a4957569b3b44e2622aae776027db07"
    sha256 cellar: :any_skip_relocation, catalina:      "c4e02b6c3fba20c6ae9485fe814e8496028afda710bcfd78f8af66c6205afdcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f9bd1c28e0459370a8ac90b3e0a7eaf85cb8b76dfe54542076cacb3e8d9f9998"
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
