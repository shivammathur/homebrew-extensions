# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5eb31b7dadbf09a848e11f047c753462f7bb2f323936ebe8a324f835584632c9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "65c1d7b80d9be2b3cb7f480e1785bef47b1bbe12a7bd455885af96db3ca26a28"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "73340e8cfd08fab31cfe4e38b0fddc97788cf2d018f8b97c3806afe05fcd1b6b"
    sha256 cellar: :any_skip_relocation, sonoma:        "be3e5ed35efb3412174832e9b68a843a2eb3cb145c2b069ad9c79756f3404a05"
    sha256 cellar: :any,                 arm64_linux:   "9f24809073c331d130a6fc89e3003056f0100a48bf2fe574dabafbe4b70460d4"
    sha256 cellar: :any,                 x86_64_linux:  "575037a4b50596d665aba9006dceb467ea8a60bfade0ee8abc4877409070316d"
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
