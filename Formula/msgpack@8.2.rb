# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6906ca8fc622d1e452552bb86b8b6c33e675ccf887ce0e13e35d8e404a84851f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "95e944a2625348897bbb493d932584f847a8d3a8a84b3e0d8bf7c1dd803ace59"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d1ded957b90b5933bfe74a97975f12c2b97a336aa790d9ec47aa8d3e295283eb"
    sha256 cellar: :any_skip_relocation, sonoma:        "e2acc20eaf968ac25f2e36a68cdcdf4352d238b4580b241fdca835ea8d0815d5"
    sha256 cellar: :any,                 arm64_linux:   "ce77639abc4a2f31aa662fe8c7b58af0ad979ce3150d605884dba64d2fa684c8"
    sha256 cellar: :any,                 x86_64_linux:  "5ecd00e08bb0740931cb3b375c9f2ca688d32c0b600370961385147e0f113f59"
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
