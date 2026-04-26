# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT86 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  revision 1
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6b84ceba3d438bbea40a7beaea5c0459e15a117c2f37901266c9f19dbf14f047"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e98fec7cae5b1b2deb7ea3bcaf013f828d9249ec009528ca57ffe43f5431f7f5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c5ef65b3089ced8ad08c03c30cdea4f376fec896d360d47383142c10ffa4fbff"
    sha256 cellar: :any_skip_relocation, sonoma:        "29ff69d998a9ca15fcad1a1672b3099a9610c592de447806ad0b25cf95ddb5bd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "975e16b11fe3ab32ed05ef29c9b054a393359e738949e39afb49b4979b28b79b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13da7581fc6fe09bff6dd5679379d6336c1209ffb2bac6688696624cb47a8a4c"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    inreplace %w[src/php_raphf_api.h src/php_raphf_api.c], "ZEND_RESULT_CODE", "zend_result"
    inreplace "src/php_raphf_api.c", "zval_dtor", "zval_ptr_dtor_nogc"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
