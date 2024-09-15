# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT70 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "41cb3365ec4c020d58684784ace2b45096f71e76bbc6ccf904cdbf4fc5a4f70e"
    sha256 cellar: :any,                 arm64_ventura:  "6962b284bec1efdad44b69a877a11028074ccf3bdd6c348162d35c7a61b179e0"
    sha256 cellar: :any,                 arm64_monterey: "2b942a7dcd065f44516455f353d12fa5efcf30f0745117f9bfda0d92eb667363"
    sha256 cellar: :any,                 arm64_big_sur:  "35d5a1c63879d98fd939e550f530d2f08f133199672162575eb7e612a4f51e77"
    sha256 cellar: :any,                 ventura:        "2f4fd30fbfbbb35d1fac9113067b7a53245cf2990efff7169d1f9ae7c6ffc079"
    sha256 cellar: :any,                 monterey:       "7249f96b866859889257048115ef3274b49b46327ddf8db583474182adc992f6"
    sha256 cellar: :any,                 big_sur:        "04820dc112cc99a655f71320be5faae2013e53668e47df1a3a52e67924afcbfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1b061a4e90d339a2e99c3a959fe360e9833f39746a528a763b6ff9522a3cc84c"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
