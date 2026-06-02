# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d4319eb2e3bc98d2289ea914a0f4aa20180db0ee4c37098adf8e85ee3408dc99"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "01843b6b9fc6501bb01eb8953dfece09046fee9cec374b51f59ec8ed0a4ba396"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45c68bf6db5f27f177e6faa72f835e2f9139155a7ccc0854525ef7f8e2868880"
    sha256 cellar: :any_skip_relocation, sonoma:        "796eb582def517e5a2eda7bacdfda72ed01c2abd6773bb013bc5cb09b05d4768"
    sha256 cellar: :any,                 arm64_linux:   "48333140e2142ca3826230cdafa88f38da83544f6a3c5d9e62253117100c1bbf"
    sha256 cellar: :any,                 x86_64_linux:  "174190a4fe199e7da314b92119977bc30cec70c2560165d30b2ec3d8d39570b7"
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
