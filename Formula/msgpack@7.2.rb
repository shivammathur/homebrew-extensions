# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6fe7e97759155ed4d47fc749fe71188749a1dcacbbda1d314724e4389d0e7e7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c2a956b58474344bc031f23c21767f48c797f7781e62f8592d3d5b68881eb813"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "11990ab41816b52c7a2754f33e3a7976a586fded883b9e9382dbf2a71a7baf8b"
    sha256 cellar: :any_skip_relocation, ventura:       "c58b4385da1f5e79e46d5ddf0010814545d29c7a4da4dbabc68928ae4de28f4b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f669764f56d4e7f4bffc9498a2d3ee6cd418c0b3cea51246ccca0b19234f56b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa17988870a2920ae929a0803a78d058aeccea88e915573a2d5561d11fdb1db2"
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
