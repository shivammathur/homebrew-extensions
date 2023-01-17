# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/msgpack@7.4-2.1.2"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "543936f0f9ce9268fdbdbabd268dc486d84b4cbbe277818ff950feea1169dc27"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "334c8b4c7cfcced9e061ae850363cd36f2ad5af60f0254446bd2c3db719e3075"
    sha256 cellar: :any_skip_relocation, monterey:       "5957f7ffcd7d20d5032b8ed12fb8463bd9b6deca359047949462ad5773c7347e"
    sha256 cellar: :any_skip_relocation, big_sur:        "0754aad2f063893f2da2e0fdfd8230ca86e7eb387ca71289fb9723767985df98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a25ab27a47d62974ef2938c2eee27c64853d839b315275b3d68c9550b6883d6c"
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
