# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "95b48720157f312e4107fa719f90b773b40db07cebe2c13423dbf3b69f26e0dc"
    sha256 cellar: :any,                 arm64_sequoia: "190928ee02d171b653cb1c19e51e42d99f5541161b027b7b4ad9cde4c21dff93"
    sha256 cellar: :any,                 arm64_sonoma:  "c4bda933c3050e4ed995c3648007c2020cb7243292f8010be3ec7e578b5875f9"
    sha256 cellar: :any,                 sonoma:        "1d461cc4ed5004cf132e448d3888b7af451bf43751df60a136c294dd272b5039"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32b16a943a9f552883022f54c4d84b6a6b6403257ba99b0c4e27c39a348a05e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86c6fa78abf80ed40c748f544fce0ebb5d1b707e2471df5c24b872593e558396"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
