# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "fffafa5391a218495f4456be9c38efe2b32f58185df88a26ad44d28bdf0041ab"
    sha256 cellar: :any, arm64_tahoe:       "36a897cf5768a87ea038b6fc68cb4e033c1eb8b98be79857c5305c9a4c7946d1"
    sha256 cellar: :any, arm64_sequoia:     "62728cbf29f11ac00e0a4404a9d424e28a6f5f4e586a57f97334adbedaf33aab"
    sha256 cellar: :any, arm64_linux:       "5a1a198ad1d38dd901e36f413820d1b0344d9075851013581759e4cddb9d2429"
    sha256 cellar: :any, x86_64_linux:      "9228596077d374ff8c895b7b74359e9426b68c0c42025870e81cda98f573e645"
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
