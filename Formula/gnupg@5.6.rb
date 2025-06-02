# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT56 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.3.tgz"
  sha256 "c1555e0c86a7f6d95141530761c1ecf3fe8dbf76e14727e6f885cd7e034bdfd2"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6a6123d4b08b202a510dc9d9e01a4476b0457fa9150b339bd18a838753ce8c83"
    sha256 cellar: :any,                 arm64_sonoma:  "210c9c4ddd4276bbae3a5a596eb326f4f689082d7e0ea17ffe7366ba969108e9"
    sha256 cellar: :any,                 arm64_ventura: "2103506da13f77edd1d938871730c95f9af68b6f75f844673b1c8ed5ced70f83"
    sha256 cellar: :any,                 ventura:       "158de8e5594dea9309a327ab3157cad44ebc65a37a016c9126bb135c8c809e8b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5f555f0a128dd67eef1ef28b72b8c18447f03047d3eb59dd85cb97c551a97852"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9bf068ec9dda56ab447aca0c1d7d9991820029389a2a24046b7c301625e2654b"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
