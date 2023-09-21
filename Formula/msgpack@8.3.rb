# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2ccd05ec4c9378cb3027130153ecf22e1a267af3fdb917f082d6d9cda52d3f78"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5088862231e994a6efb62f596ecb907f6e673314366218399129bc2fb16278be"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "71b2c1eb15c66c004a6382bd71609f6d832ed4ac09175669d1fe24f068448ac5"
    sha256 cellar: :any_skip_relocation, ventura:        "6a5add127ae94a6e0936b58926f55b1b8fa254315e4ceb3a2d5f1e1ab9a05ad4"
    sha256 cellar: :any_skip_relocation, monterey:       "e9a67844eb11f76b064d2b15d77c588fc8c86e74b7975d6a894a7a329baae1af"
    sha256 cellar: :any_skip_relocation, big_sur:        "2fa52bc6e4265dd844d5578fec1bbf2f65ecd62b9dbd51c2b39622c30ce7811c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe2f7112f2dc12ab135342c4dd8090884cea1f2b8919f984e7e87f1cf57c9091"
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
