# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT85 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d38a8d5f6557023e8ae18515c4dcb9d6741b42917c3b72185b582cefcdc32f27"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "412cf4c90979b5bb5be510d01c6eca28934f4b09cb28951d51d6c0e386c0134b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9c046674a47464e9c2d9a3d1b7048c907f947cac71e2f190249177f317725403"
    sha256 cellar: :any_skip_relocation, sonoma:        "a7982d07bb223106c4be6e28fadca4238d2db262691a408a4ba607c2361dac8b"
    sha256 cellar: :any,                 arm64_linux:   "bb40c775cb6d9bdb75be12fadeb3d9d5f67cbbae2c171d3304386fa6b50b122e"
    sha256 cellar: :any,                 x86_64_linux:  "6f984307f5d4d693926976736eaee1e582d1ab4ff4ec53bfec4ec85e412eab61"
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
