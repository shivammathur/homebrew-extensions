# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT82 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7113ff640c67197ba298b3b952e61fcdb9986aff4a63170facdbdc15ac859b5a"
    sha256 cellar: :any,                 arm64_sequoia: "ffd9d1da762d3a567edc98e7ebd79d2ac134d8bae3c1044a1217e303b34d956d"
    sha256 cellar: :any,                 arm64_sonoma:  "e0a4f127f98aa81fb2d73f7900288db1271bcddf8b69ab40a6398a4c721d3088"
    sha256 cellar: :any,                 sonoma:        "fc94a0fa4274ac04e4e06e0b14ef57909d53304e4ac6a175b2c6c84a0a4d1c4a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2299101c33b78988f154c91adfed7201aa25db201cb2aabaeae038b6bdf2db89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c31836bd4308ac86388af42e7eba2bacd54d2efa73fdfa131b560a22bc49076"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "019300f18b118cca7da01c72ac167f2a5d6c3f93702168da3902071bde2238f9"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
