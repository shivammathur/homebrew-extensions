# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "fc29291036c77c094fa90eee4b1ba1cdcc25c6723b90693ad1ed90af7efe64b0"
    sha256 cellar: :any,                 arm64_ventura:  "ef2b8f587038bf207d797081561a621c8c6d24cdd6f162c881aecb12dfd280c8"
    sha256 cellar: :any,                 arm64_monterey: "31709765be7b65b85f638151fdac4a06bf6bc2521d02e2667ccc325d60b545c1"
    sha256 cellar: :any,                 ventura:        "0447509a3e0f438d219e2c3211b78c4ddca2bcf8a97f0609d5fa2690e5e74b52"
    sha256 cellar: :any,                 monterey:       "8bdcecd9c4c1372d35aec537d63af64ec13186ae9262276a61f866470b6e6382"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5bd2ef58fadf948631c3783eecb39c333ecdce0b1472d4f7fd62dd2912b2c08"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
