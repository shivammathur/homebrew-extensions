# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1376863becde4abcc2acdb3361030d2f38a835e025bed77f1d6c28e98797c233"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "84591ff2d3aae2876f343fa5ffcd644454bf269fb8eca565dda99b6376aefc33"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5b5fc5289ea0be40543144837d0d08864c3c44db4e0207ad8f7bbdb41af42fed"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9653ac1441dfb56e0eeb393e4e926bb25c1befb8c93599db2932c9101a3627ea"
    sha256 cellar: :any_skip_relocation, sonoma:        "15e6665258374f33f9a2de772cea4b91ca34a49fc4a6d8f24ee577c997bfa1e6"
    sha256 cellar: :any_skip_relocation, ventura:       "11dfa71c7e471dd741e1ab87ceb4a6f5b7fa1e27764b74925f355f7da91764e4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "83984c8a78f50eabd056ba3a0d5216cc45a4919f70971cdc9a3c135c6ba24022"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb115ec7c1a0dea4625e2c2ece0b57adf6bc9da54be8b5b86be7057edd7bef09"
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
