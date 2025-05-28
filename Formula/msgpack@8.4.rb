# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT84 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3248e2342a51ac549c278778ae5ab32b70eb39bf75765e4d2c74ed716489b047"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "78f92d8b10e4ec2c50b945a24344a2d8e8464a92469070e085c9376ce66d571a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f2ddc8083f1b10b6412a6710b32fad505f62cbfd2cff93cec5650bb224588639"
    sha256 cellar: :any_skip_relocation, ventura:       "babc8224faa0bc1cc6ba3c4ac49b2a27e27ff9be8ce1bd7004384e9583772121"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "038f077d747c946ef23a7d4e64003b9247c580035cba0bc2366aef580dee2e75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "562e552773d781c5c0dffc3b80fd2687a9fb8ab2121d28d89a3577307edc5651"
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
