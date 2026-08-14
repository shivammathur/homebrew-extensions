# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "0ef7f0a65c42ecd6602f2fa65529eaa83b0faea7fca491d66f94e411c050aa40"
    sha256 cellar: :any, arm64_sequoia: "22c43f98e617f4b948006f699ed0856634f8d9d2ffee691829e8caffbcf8e831"
    sha256 cellar: :any, arm64_sonoma:  "69b40a6d3caeafba33e5645f72ba390f5610de531b9b31a1dc800f5f91588bbf"
    sha256 cellar: :any, sonoma:        "339fb258b97cd1974f1d946b288063824680d507f1537ae0bf0d9c4955872f26"
    sha256 cellar: :any, arm64_linux:   "0eb611c54a6a03b8bab4186983aea6aa38371866c686b81b88b43d17434018c8"
    sha256 cellar: :any, x86_64_linux:  "b513aaf365841a1993fa16b237b9d90037ba47b290f02c32f560019c4cbf7920"
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
