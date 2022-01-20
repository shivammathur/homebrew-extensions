# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "92b83a01f5e428f3567d34880734cbc249700726a1bfa57a3ee3381c59a7ddde"
    sha256 cellar: :any_skip_relocation, big_sur:       "4d30d429962f96bdb0e4436b0cc52dfec7b0f800ad4253cbaefd3339fb6f11c8"
    sha256 cellar: :any_skip_relocation, catalina:      "850b059c74127e72a27abdb03cca2a43b5d31f2044d9ba3087a408fec2f2e486"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e09e06127374929fb3c51c3322dc172d891bcb11df4963f16dab9cfc9a72cc0"
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
