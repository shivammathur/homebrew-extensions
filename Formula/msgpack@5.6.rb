# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT56 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bd3d00c287dd648433d9cd506c326583f2ffbf24b38ba30bf80e951a8c16597c"
    sha256 cellar: :any_skip_relocation, big_sur:       "0473262c9c2a1b0635ea8e7ba955df499ab07cdc02130c9a858b32e03fbd6d50"
    sha256 cellar: :any_skip_relocation, catalina:      "8916556384bb7b1dbffe0bb157b8af120491422fc960b01953ea13a082c6e405"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
