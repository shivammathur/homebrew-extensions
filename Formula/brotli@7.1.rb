# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT71 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "7fe1d3ebfdafdee621d59993deded7aae9afaaa6add93a5928b6077f754f491f"
    sha256 cellar: :any, arm64_tahoe:       "e665151b7a4a512fe0a81b3c9db4b221260579ecf761db75ab6af624364fef0e"
    sha256 cellar: :any, arm64_sequoia:     "42326d9877ebd5a865e779c195519e14ff672174a689622f02ea31a3d86f897e"
    sha256 cellar: :any, arm64_linux:       "7c510044d0e8a5506ca700c1401440f6cb7657e19938fd23fa03cdd0f8700a85"
    sha256 cellar: :any, x86_64_linux:      "e167a865239f20e478cfc8d9846c3cfe03b6e0112d739908ad4c23088cd84043"
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
