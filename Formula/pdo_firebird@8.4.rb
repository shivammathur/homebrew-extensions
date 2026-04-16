# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.20.tar.xz"
  sha256 "e454c6f7c89a42f41ebb06dc5c3578e8c8b5f1a3f0da6675665affab04e221f7"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "31af0aeabc497f87156610d4858be6cc92bcde34102edc89c4ebdcc78ecfd801"
    sha256 cellar: :any,                 arm64_sequoia: "c725c793ed2ccbaf9056f792e682e4712bf124c8d876e394f6ffdcf3e6e80e0d"
    sha256 cellar: :any,                 arm64_sonoma:  "8109760567263ad123551cf2f3bec6bfc89e08495d9ff69be4532b1c5f9b588f"
    sha256 cellar: :any,                 sonoma:        "546e04afde8f6a8ea926efd3bd4feaf3417ad223995a7f79c8a72e8c8817c176"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "13f0d36df039794e07fa6419cd07ffde484eedf1691d10e10e5780b468aabbba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89cb40e124009e58cd345979db6996051019b6689fb586efea4c8c878205c12e"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
