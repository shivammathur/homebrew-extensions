# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0c7acd6c7882a4637695ea89fd34229d2e6e768d7ef4695bab625e73f5922c7d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "014e10ce752862f63fa9f62b0547c80f5ee3013833a0083c6228fd3d5b6e3c46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b41d90be791ff53a9ba5f4bf811dcda63d38295af455aaebff6f1f43c1c9f6e"
    sha256 cellar: :any_skip_relocation, sonoma:        "e7736636f1e8db7e23bf896ffc3c9729a0f013c0cd9d2d237860a31c2a316b76"
    sha256 cellar: :any,                 arm64_linux:   "0fc769a73134aa0a8dd8eb83c8175c4da274d3203bb364214e286aac4e417d3c"
    sha256 cellar: :any,                 x86_64_linux:  "d00ee63bad8c9dea62c7e58420eaf405129bc120417de6c9d8b75d7a048b1b89"
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
