# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.6.tar.gz"
  sha256 "4ac1a0032cc2a373e4634ec8123fc6e1648ca615c457164c68c1a8daf47f4bcc"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "82e9283ec74afb92eec5969a6edd16fc24b08067b49c5589a56ab524f60f3b24"
    sha256                               arm64_sequoia: "3111e6e7416c7d7cc52671c040ba904dfa0571c055b76aaa25a2aada15fe0e7e"
    sha256                               arm64_sonoma:  "03ad49af4ecba2cdd27b957cbc024c562b05b68b5e6e1a53ae81f7ae7a622a17"
    sha256 cellar: :any_skip_relocation, sonoma:        "2bafeead79bf212476aea7f032db5b2d571f7f55d38fa77e30a0eebfc0ca3456"
    sha256                               arm64_linux:   "d2268bbb01b43a088419bf4e5512e41a75c02e81d7fcefe4bfe0a78b6ff6c7b7"
    sha256                               x86_64_linux:  "a57637356431907d43587e8d5093f369be6aac92c549ad82bc132f61b86034c4"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
