# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "d6bd91346f90eb82972ea992da1e7d9c3358e35f761e61cf88824780025fe955"
    sha256 cellar: :any,                 big_sur:       "c07cf63d699f0d93211e73609e4df0e65e6b8b1318351786e9dd3aca5b1d38a3"
    sha256 cellar: :any,                 catalina:      "e3dc019abe423877466d53e52ed1edcd97a5fcdee1baf737327b4383bea6ea98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5472b09e28d556c1fffb54be79cd8518931ea85ce51e23b72cfea3a0e7ab83f2"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
