# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9f1b01926f71a22230133326e878101289d96b47f3bb7ca506359c1de5ed3cc7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "34d5b87b69d85acd20e86d1c20c8c169db1ade3b72517950fab50c9aaf0a4859"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "328a315afa7980e59dc172a936749901521492556301c59d648872d5ad55e91b"
    sha256 cellar: :any_skip_relocation, sonoma:        "ef70eff1788247a5b2c207f16e668c903e60c5893595ef50c2fbd00c3ee407ae"
    sha256 cellar: :any,                 arm64_linux:   "475572a6f111b18b0146935143686b42715c4b650a2b23c3803f4e8e94040131"
    sha256 cellar: :any,                 x86_64_linux:  "ac1d2242692466446773a617707be0bb8aa8d4558f390034a9df2acaa99cbf3e"
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
