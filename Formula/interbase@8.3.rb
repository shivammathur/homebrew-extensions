# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT83 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "560f0863ef7811c1fb9b61f80f1d0f03abc39496c8db010955537b26a5fd4e1d"
    sha256 cellar: :any,                 arm64_sequoia: "9ec5a96431cf1d120c1fc01abaf9ec351e5cfd59ff5d856870a3d37c7d4ee9fd"
    sha256 cellar: :any,                 arm64_sonoma:  "773083fbef8f2fb544c81d9c72830938a6ef192da8dd91976962de1d505008de"
    sha256 cellar: :any,                 sonoma:        "495c9fc3ba26e882e946a885d2d228249004d64f739c51a81a74a934d6ccca4b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a47083eb9944dedd0c76900f4413cfb9e3501999aca597a544d5b57ded266a47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "562c436df7433d67219443c24e359573349ae2c8ff2cf2acc69897b9940c5196"
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
