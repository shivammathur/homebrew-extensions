# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT73 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "190e1dfd7cc90d1cfb53559df45900e9fe6745b0bf3b97e495b0cd52f3f50cac"
    sha256 cellar: :any,                 arm64_sequoia: "c9a5282b4984a189e3f1196ef40df9e9b9200254ff16cd311eb0553cf9dbc0d7"
    sha256 cellar: :any,                 arm64_sonoma:  "101a8ea454bd2437b7425e9ded5b18b9d3a29ebe7a8ab506bb502f5144b6d11c"
    sha256 cellar: :any,                 sonoma:        "6c351f879c7deeec4c360d5f5f1f19c66b32b6500698f8870eb039a4e68e8ade"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ca4a38e74d8143b223ef4e56eea85d7dca365d35e416f6850e79fd9c0df5ceb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dc8efc5f246b66f18f736bb9e1cdbf8680a77dd585542b8c8bff40a38b47bb3"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "019300f18b118cca7da01c72ac167f2a5d6c3f93702168da3902071bde2238f9"
  license "PHP-3.01"

  livecheck do
    url "https://github.com/FirebirdSQL/php-firebird/tags"
    regex(/^v?(3(?:\.\d+)+(?:[-._][A-Za-z0-9._-]+)?)$/i)
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
