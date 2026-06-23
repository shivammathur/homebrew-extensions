# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "364872422da7789201b4e93b135ed5fd436f0df4aec457c4419fe64bb5b41a8f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c33ff2ee56db2b52d941e223eeed264c9feddf788cf31a0fc6d0cc93508d6076"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "49a4c7d18594b3c7d2d889167314660abc0cc86e3e4128b9700a55d142cc147a"
    sha256 cellar: :any_skip_relocation, sonoma:        "9abcb8ca266550192c3fce89eb742add18e6c73e9297d1957378de90357747f6"
    sha256 cellar: :any,                 arm64_linux:   "8333a690a6e59b9d95cff1a96ccaa9367d0057e147f95ebcf61c17c3eb308696"
    sha256 cellar: :any,                 x86_64_linux:  "556e3dd9a3b75d4e149d3b9fe211b19e501a106cfd7edb49599f4b2b09321577"
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
