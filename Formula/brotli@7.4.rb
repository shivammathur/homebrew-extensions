# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.20.0.tgz"
  sha256 "e8d303afa3df0afc4e1362496482e3d20052b3bb478027b597073c8114d1f2ea"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "9ed3651ecb6257f8a46ed59ad60870effab6f878658713ed9f6d2066000d364e"
    sha256 cellar: :any, arm64_sequoia: "200929428957d08937e48280455318a75f56258e5552bf338dc5d9c026db3517"
    sha256 cellar: :any, arm64_sonoma:  "5bd946ac546cb32b6ec3221cd326a6840713180f76a45069457b180c8b402931"
    sha256 cellar: :any, sonoma:        "1c152b2682f8ebd309d3e8ec26943efad09db2f3eba04e913c31106c1e1e7652"
    sha256 cellar: :any, arm64_linux:   "f69d0bd6e1a662266bea19c768d316c3532bd65ddbe7160ebbbee1054c7db873"
    sha256 cellar: :any, x86_64_linux:  "f6e88ca009bfd17adf82ef90fa74388a915ac6afcb52a16d36d518ae7cbc4c66"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
