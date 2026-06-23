# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/17961920bc943802ee35637d0ed2269df3acb313.tar.gz"
  version "7.3.33"
  sha256 "348e8c7a07899abcb9e31aeebf082ce9c47178ad274879abbd88e632830d1d16"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "8bb920e877f17f367509039455af79c157653f3b82d1460129dd237564cf5dda"
    sha256 cellar: :any,                 arm64_sequoia: "2630751e48876b50051797cb45401b66acceb950b2bd3c133b384f6597e0e0de"
    sha256 cellar: :any,                 arm64_sonoma:  "86eb23478411c2defc0093b9145ac7e3365280156b39fafc3d2b72557a19fe13"
    sha256 cellar: :any,                 sonoma:        "44335948d1c83a1ff034b0329885c45c8663a0b5f55c253c8304f3abb5a0d5d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "578c484a094aedd7895ee627fbc4a1e46d42131ed25737ab54127865346cdf8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4bd51dd13df92eccfe11a16a9a75faaa6d5007995471c9b6623101c66bda9d9"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
