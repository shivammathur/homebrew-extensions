# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "800e0ab341fc32d9e76db3dba466f9cfa97ddffeb48bf78f0528144016dd1f57"
    sha256 cellar: :any,                 arm64_sonoma:  "093fb8f64036c5578ab67dc380eee95e0eaad97a53aae0491c641a9be12cca54"
    sha256 cellar: :any,                 arm64_ventura: "430d9a664680c1f4b40a51ec267d55912b2901c454cc3dc61970d1c663c16dbb"
    sha256 cellar: :any,                 ventura:       "a43d15739ecaf0b28a014585cdc5b24de329dd881efe2df14c66900c551ee433"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b28bb0084c639c34a9a15c83fa578a7f39ee1255938699760f9fb5d3afc7f674"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
