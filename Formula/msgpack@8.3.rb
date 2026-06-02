# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "198629136b1e18e3d2983ed098f44af5151ea2f3b53929980e4d1fef965e2a44"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "632252fa218641bea2c9b31127281944fb2d30915b5b615ce2c37bb40ffe3477"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cbf01264c43dd02bb841c59b7c2a9bfa4945e872a29749f8cef80e6766c2a0fc"
    sha256 cellar: :any_skip_relocation, sonoma:        "66e0e7a1bb6bf708ae20b7af92125d957a2cd41b0b2548fed5dd71010bbcab79"
    sha256 cellar: :any,                 arm64_linux:   "8abf42be27015dc2430e58bec107d17fcc9ecfba8727a6756c9c0c188468bf13"
    sha256 cellar: :any,                 x86_64_linux:  "c3525067d542df31efebc55aa51fdcf82c4d424957c3751813b0558fbceed99d"
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
