# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/89687719b40691a773bd57a20147288c2fa278fc.tar.gz?commit=89687719b40691a773bd57a20147288c2fa278fc"
  version "8.6.0"
  sha256 "f7844d09806f1d8dcf2a763e0dfedcab0a3b3e8a3fa9b71281db33ea43dd40ac"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any, arm64_tahoe:   "e595412f2c7838b02b21c6834887b2f911e03089234f1fd2c256e291ac824906"
    sha256 cellar: :any, arm64_sequoia: "4342f76fb3f3c01aa57cc5b3c910caa792bd3c40afc507e5f677f34bb0cb416c"
    sha256 cellar: :any, arm64_sonoma:  "b5148377cacc48ea2fce46d7b2a95ec659e0d2a80da1b601d178c8bba7f5b1e3"
    sha256 cellar: :any, arm64_linux:   "0f779f5664e07141fa6d3db3b57d072f98edb051e2b46568944d58624b54dddd"
    sha256 cellar: :any, x86_64_linux:  "592b7f36133b9f97268b6f66e11186406cf7f7cfbfc5fa9d921bd64123f75577"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
