# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1989bc9468b8aaa3b6d6fa8ff094833984ea63db300a3a7af5763da973e20960"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "38ed6fece2d755f6f0e387f8405927b1c7afd88b38162e760801bb0407d6c95a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "528c126a372db843067436b878a70a2344a9ecaab67a620c3ad6997e67924c74"
    sha256 cellar: :any_skip_relocation, ventura:       "101102cb32fa522aee18bb3da582e0128382085aa6e50c692ebf5d28cf945595"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2d603b11b3e9d44515a105dfbe82d3700fef0b3ceafc9e32d302050c546222a"
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
