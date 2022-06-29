# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8942e15b2f19eccfc5c703faeac33ac4c25187d6868a39cb8ba7079aec253e8c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "12bb646cefa7b38bdc5e6a3205a60a9b533165abfbc143cf6405344479abdcac"
    sha256 cellar: :any_skip_relocation, monterey:       "df620050205b6e6a287910e0bc12aaec8bd77653defccd2537551b836c82a5dc"
    sha256 cellar: :any_skip_relocation, big_sur:        "87dc6efbd7ffc4c53facbdcca9034ea64e730632d27f34842eb47c7cc0a94aab"
    sha256 cellar: :any_skip_relocation, catalina:       "2c614b7abf100847510a17a199463859b7b8e977fb4343bc1f9080e9c077a079"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9acb36c30d69b23d26f30011a06524e01cdbe91d3b6f3669c6fcabc147af4129"
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
